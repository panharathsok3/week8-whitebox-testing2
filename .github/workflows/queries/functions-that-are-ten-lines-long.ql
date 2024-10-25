/**
 * @description Find functions that are longer than 10 lines
 * @kind problem
 * @id javascript/functions-longer-than-10-lines
 * @problem.severity recommendation
 */
import javascript

/**
 * Holds if a function is longer than 10 lines.
 */
predicate isLongFunction(Function func) {
  func.getNumLines() > 10
}

from Function func
where isLongFunction(func)
select func, "This function is longer than 10 lines."
