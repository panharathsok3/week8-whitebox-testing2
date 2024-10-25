/**
 * @description Find tests that call a function named "pressActionKey"
 * @kind problem
 * @id javascript/tests-calling-pressActionKey
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
 * Holds if 'caller' contains a call to a pressActionKey function.
 */
predicate callsPressActionKey(Function caller) {
  exists(DataFlow::CallNode call |
    call.getEnclosingFunction() = caller and
    call.getACallee().getName() = "pressActionKey"
  )
}

from Function test
where isTest(test) and
      callsPressActionKey(test)
select test, "This test calls the function 'pressActionKey'."
