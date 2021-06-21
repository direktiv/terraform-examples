# Terraform Direktiv Examples

Each directory contains a small example of how to run Terraform and the yaml that would coincide with running it on Direktiv.

To use Direktiv variables as the Terraform state.

You need to add an extra argument to the 'init' command.
You need to also provide the 'state-name' as a variable.

```json
{
    "args-on-init": ["-backend-config=address=http://localhost:8001/STATE_NAME"],
    "variables": {
        "state-name": "STATE_NAME"
    }
}
```

**Note: 'STATE_NAME' will be saved as a workflow variable which will contain the Terraform State**