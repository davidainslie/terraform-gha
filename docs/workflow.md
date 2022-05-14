# Workflow

We'll need access to AWS for this demo:
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY

## Steps

Terraform Cloud portal:
- Create Terraform Cloud `workspace` (and if necessary first create an `organisation`)
  - New Workspace > API-driven workflow, where we'll name our workspace `github-actions-demo`.
- Add environment variables (where Terraform cloud handles the necessary `TF_` prefix... I think)
  - `variables` > Environment variables > Add variable:
    - `AWS_ACCESS_KEY_ID` = ???
    - `AWS_SECRET_ACCESS_KEY` = ???
- Create an API token (save it somewhere)
  - User Settings > Tokens > Create an API token, where we'll name ours `github-actions-demo-token` (save the token somewhere).

GitHub Repository:
- We'll need a `repo` - well, we already have on here, but another can be created.
- Create a new secret named `TF_API_TOKEN`.
  - In GitHub go to Settings > Secrets > Actions > New repository secret:
    - `TF_API_TOKEN` = <Terraform Cloud token (previously created)>
- Use our previously generated Terraform API token.
  - We'll need a `workflow` file - see [GHA workflow](../.github/workflows/terraform.yml)

AWS:
- Once a PR is merged to `main`, our application should be deployed onto AWS with the necessary resources provisioned.
- In GHA open the `step` named `Terraform Apply` to see the URL of our deployed app e.g.
  - web-address = "ec2-54-211-70-151.compute-1.amazonaws.com:8080"
  - We can also view this on `Terraform Cloud`. Go to Overview > Outputs tab
- We can finish up by destroying all resources and do this with Terraform Cloud:
  - In Terraform Cloud workspace go to Settings > Destruction and Deletion > Queue destroy plan > Confirm
  - Within this tab, we could also `Delete Workspace`.

Let's double check:
```shell
http ec2-54-211-70-151.compute-1.amazonaws.com:8080              
HTTP/1.0 200 OK
Accept-Ranges: bytes
Connection: close
Content-Length: 13
Content-type: text/html
Date: Sat, 14 May 2022 18:05:54 GMT
Last-Modified: Sat, 14 May 2022 18:00:23 GMT

Hello, World
```