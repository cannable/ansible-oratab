# Super Primitive oratab facts.d Ansible Implementation

## Installation

1. Pop this into /etc/ansible/facts.d/oratab.fact and make it executable.
2. Yeah... that's it.

# Testing with Ansible

```
ansible oratest -m ansible.builtin.setup -a "filter=ansible_local"
```

# Testing Invocation

If you pass no arguments to `./oratab.sh`, the default oratab is /etc/oratab.

You can also run the script against a different path:

 ```
 ./oratab.sh /path/to/oratab
 ```

