# LHS/RHS operator
===================

Selects LHS/RHS of the equal-sign (or colon).
Therefore it may be labelled _value-operator_ or _property-operator_.

This completes accurately the common operators. In particular,
I like having this mapped on the **omap_v** (mnemonic: **v**alue), 
which isn't used in operator-pending mode, and **omap_p** (mnemonic:
**p**roperty). Therefore you can quickly issue `cv`(_change-value_) 
or `yp` (_yank-property_).

It works smoothely with the following syntaxes:
`vimscript`, `javascript`, `markdown`, `lua`, `coffeescript`
probably `C/C++`, `java`
(No mention means untested)

Usage: (No default mappings)

```viml
omap p  <Plug>(operator-lhs)
omap P  <Plug>(operator-Lhs)
omap v  <Plug>(operator-rhs)
omap V  <Plug>(operator-Rhs)
```

```viml
vmap =h <Plug>(visual-lhs)
vmap =l <Plug>(visual-rhs)
vmap =H <Plug>(visual-Lhs)
vmap =L <Plug>(visual-Rhs)
```

Demo
```javascript
let dict['value and = signs and colons :: '] = [ 45 ];
```

## License

Same as JSON, as long as I'm concerned, 
but most of the code here is freely adapted from
[Learn Vimscript the Hard Way][1] (eternal thanks to Steve Losh)

[1](http://learnvimscriptthehardway.stevelosh.com/)

<!--![alt text](./pp_self2.png "")-->

