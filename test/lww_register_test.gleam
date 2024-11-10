import gleeunit
import gleeunit/should
import lww_register

pub fn main() {
  gleeunit.main()
}

pub fn merge_same_timestamp_test() {
  let reg1 = lww_register.new(0, "node-a")
  let reg2 = lww_register.new(1, "node-b")

  reg1
  |> lww_register.merge(reg2)
  |> lww_register.get
  |> should.equal(1)

  reg2
  |> lww_register.merge(reg1)
  |> lww_register.get
  |> should.equal(1)
}

pub fn merge_different_timestamp_test() {
  let reg1 = lww_register.new(0, "node-a") |> lww_register.set(2, "node-a")
  let reg2 = lww_register.new(1, "node-b")

  reg1
  |> lww_register.merge(reg2)
  |> lww_register.get
  |> should.equal(2)

  reg2
  |> lww_register.merge(reg1)
  |> lww_register.get
  |> should.equal(2)
}
