/**
 * @description Find all public methods that are called by tests
 * @kind problem
 * @id javascript/public-methods-called-by-tests
 * @problem.severity recommendation
 */
import javascript

/**
 * Holds if a function is a test.
 */
predicate isTest(Function test) {
  exists(CallExpr describe, CallExpr it |
    describe.getCalleeName() = "describe" and
    it.getCalleeName() = "it" and
    it.getParent*() = describe and
    test = it.getArgument(1)
  )
}

/**
 * Holds if a function is public.
 */
predicate isPublic(Function func) {
  func.getAccess() = "public"
}

/**
 * Holds if `caller` contains a call to `callee`.
 */
predicate calls(Function caller, Function callee) {
  exists(DataFlow::CallNode call |
    call.getEnclosingFunction() = caller and
    call.getACallee() = callee
  )
}

from Function test, Function publicFunc
where isTest(test) and
      isPublic(publicFunc) and
      calls(test, publicFunc)
select publicFunc, "This public method is called by a test."
