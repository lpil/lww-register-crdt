//// The last-write-wins register CRDT.
////
//// CRDTs (conflict-free replicated data type) are data structures that can be
//// can be merged in any order and always get the same result at the end.
//// They may be useful for making distributed programs where not all the nodes
//// are able to co-ordinate to change agree on program state.

import gleam/int
import gleam/order
import gleam/string

/// A CRDT that is container for a single value.
///
/// It also contains a timestamp of the last change, and an id for the node in
/// the distributed program that last set the value. 
/// This id might be the computer hostname or some other unique id.
///
/// This type is not opaque, but you should prefer using the functions provided
/// to interact with it rather than modifying the values directly.
///
pub type LWWRegister(value) {
  LWWRegister(value: value, timestamp: Int, id: String)
}

/// Create a new register with the given value, for the given id.
///
pub fn new(value value: value, local_id id: String) -> LWWRegister(value) {
  LWWRegister(value:, timestamp: 0, id:)
}

/// Set the register value and id. Also increments the timestamp.
///
pub fn set(
  register: LWWRegister(value),
  replacement value: value,
  local_id id: String,
) -> LWWRegister(value) {
  LWWRegister(value:, id:, timestamp: register.timestamp + 1)
}

/// Set the register value.
///
pub fn get(register: LWWRegister(value)) -> value {
  register.value
}

/// Merge to registers together.
///
/// Whichever register has the highest timestamp will be the one whose value
/// remains after the merge.
///
/// In the event that both timestamps are the same the one with the greater id
/// is used.
///
pub fn merge(
  left: LWWRegister(value),
  right: LWWRegister(value),
) -> LWWRegister(value) {
  case int.compare(left.timestamp, right.timestamp) {
    order.Gt -> left
    order.Lt -> right
    order.Eq -> {
      case string.compare(left.id, right.id) {
        order.Gt -> left
        order.Eq | order.Lt -> right
      }
    }
  }
}
