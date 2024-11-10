# lww_register

The last-write-wins register CRDT.

[![Package Version](https://img.shields.io/hexpm/v/lww_register)](https://hex.pm/packages/lww_register)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/lww_register/)

CRDTs (conflict-free replicated data type) are data structures that can be
can be merged in any order and always get the same result at the end.
They may be useful for making distributed programs where not all the nodes
are able to co-ordinate to change agree on program state.

```sh
gleam add lww_register@1
```

Documentation can be found at <https://hexdocs.pm/lww_register>.
