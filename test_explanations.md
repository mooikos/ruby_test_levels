# explanations

[To be completed]

## unit tests
* only method
  * a single method is tested 'in isolation'
  * the call to the method is 'driven'
  * the calls to dependency methods are mocked
  * intent is to test complex algorithms / calculations
* only classes
  * a single class is tested 'in isolation'
  * the calls to the class 'public interfaces' (object oriented style) are 'driven'
  * the calls to dependency classes are mocked
  * intent is to test behaviour of the class
* class 'cluster' (? overlapping with integration ?)
  * a logical group of classes is tested 'in isolation'
  * the calls to the group 'public interfaces' (object oriented style) are 'driven'
  * the calls to dependency classes are mocked
  * intent is to test behaviour of a logical module

# integration tests
* X + Y class 'cluster' (? overlapping with unit ?)
  * a logical group of classes is tested 'in isolation'
  * the calls to the group 'public interfaces' (object oriented style) are 'driven'
  * the calls to dependency classes are mocked
  * intent is to test behaviour of a logical module
* All classes of a 'system' (or microservice) (? overlapping with system ?)
  * the given system is tested 'in isolation'
  * the calls to the system 'interfaces' are 'driven'
  * the calls to dependency systems are mocked
  * intent is to test behaviour of the system
    * (open question) what is the behaviour ?

# system tests
* All classes of a 'system' (or microservice) (? overlapping with integration ?)
  * the given system is tested 'in isolation'
  * the calls to the system 'interfaces' are 'driven'
  * the calls to dependency systems are calling a mocked dependency (? similar to integration ?)
  * intent is to test behaviour of the system
    * (open question) what is the behaviour ?
    * (example) see the difference between backend and frontend 'systems'

# system integration tests (? End to End / E2E ?)
* All (or a subset) the 'subsystems' of a system/product integrated together
  * a given product functionalities are tested
  * the user actions are performed (or 'driven')
  * no calls are mocked (system is production like)
    * potentially external dependencies (in terms of enterprise) could be mocked
  * intent is to test the product (or specific parts of it)
