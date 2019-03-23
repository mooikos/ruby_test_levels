# frozen_string_literal: true

class LogsNetwork
  KEY_LOGS_OUTGOING = 'Network.requestWillBeSent'.freeze

  RETRIES_AMOUNT = 15

  attr_accessor :page
  attr_accessor :matching_domain
  attr_accessor :logs_performance
  attr_accessor :matching_logs

  def initialize(options = {})
    @page = options[:page]
    @matching_domain = options[:matching_domain]
    @not_supported = false
  end

  def init_relevant_logs(reset_collection: true)
    relevant_logs = collect_relevant_logs
    # this will silently fail on drivers different than supported ones
    return if @not_supported

    @matching_logs = [] if reset_collection

    urls = parse_urls(relevant_logs)
    parse_params(urls)
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/MethodLength
  # assert that a given hash is partially included once in the logs
  def assert_contains_log(options = {})
    return if @not_supported

    expected_log = options[:expected_log]

    occurrences = 0
    retries = 0
    while retries < RETRIES_AMOUNT && occurrences < 1
      occurrences = occurrences_count(matching_logs, expected_log)
      break if occurrences > 0

      sleep 0.2
      init_relevant_logs(reset_collection: false)
      retries += 1
    end

    return if occurrences == 1

    if occurrences > 1
      raise self.class.to_s + ": Expected network logs:\n" \
            "#{matching_logs}\n" \
            "to contain network log:\n" \
            "#{expected_log}\n" \
            "only once, it has been found #{occurrences} times"
    end

    raise self.class.to_s + ": Expected network logs:\n" \
          "#{matching_logs}\n" \
          "to contain a network log with following parameters:\n" \
          "#{expected_log}"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/MethodLength

  private

  def collect_relevant_logs
    logs_performance = collect_browser_logs_performance
    return if @not_supported

    relevant_logs = []
    logs_performance.each do |entry|
      my_message = JSON.parse(entry.message)

      if request_outgoing(my_message) && request_from_domains(my_message)
        relevant_logs << my_message
      end
    end

    relevant_logs
  end

  def collect_browser_logs_performance
    page.manage.logs.get(:performance)
  rescue Selenium::WebDriver::Error::UnknownError => _exception
    p 'WARNING: LOGS WILL NOT BE TESTED --- The used driver does ' \
      'not have activated Performance Log'
    @not_supported = true
  rescue StandardError => _exception
    p 'WARNING: LOGS WILL NOT BE TESTED --- The used driver does ' \
      "not allow 'manage' function for the Logs"
    @not_supported = true
  end

  def parse_urls(relevant_logs)
    urls = []

    relevant_logs.each do |entry|
      entry_url = entry['message']['params']['request']['url']
      urls << URI.decode_www_form(URI(entry_url).query)
    end
    urls
  end

  def parse_params(urls)
    urls.each do |entry|
      parsed_url = Hash[*entry.flatten]
      @matching_logs << parsed_url
    end
  end

  def request_outgoing(my_message)
    my_message['message']['method'] == KEY_LOGS_OUTGOING
  end

  def request_from_domains(my_message)
    document_url = my_message['message']['params']['request']['url']

    document_url.start_with?(matching_domain)
  end

  def occurrences_count(hash_list, expected_hash)
    occurrences = 0

    hash_list.each do |hash_entry|
      # initially assume match
      occurrences += 1

      # loop on value keys
      expected_hash.each do |tracking_key, tracking_value|
        next unless hash_entry[tracking_key] != tracking_value

        # remove assumption of match
        occurrences -= 1
        break
      end
    end

    occurrences
  end
end
