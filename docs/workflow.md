# Workflow

We'll need access to AWS for this demo:
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY

## Steps

Terraform Cloud portal:
- Create Terraform Cloud `workspace` (and if necessary first create an `organisation`)
  - New Workspace > API-driven workflow, where we'll name our workspace `github-actions-demo`.
- Add environment variables
  - `variables` > Environment variables > Add variable:
    - `AWS_ACCESS_KEY_ID` = ???
    - `AWS_SECRET_ACCESS_KEY` = ???
    - `TF_ACCOUNT_ID` = <used without prefixed within terraform>
- Create an API token (save it somewhere)
  - User Settings > Tokens > Create an API token, where we'll name ours `github-actions-demo-token` (save the token somewhere).

GitHub Repository:
- We'll need a `repo` - well, we already have on here, but another can be created.
- Create a new secret named `TF_API_TOKEN`.
  - In GitHub go to Settings > Secrets > Actions > New repository secret:
    - `TF_API_TOKEN` = <Terraform Cloud token (previously created)>
- Use our previously generated Terraform API token.
  - We'll need a `workflow` file - see [GHA workflow](../.github/workflows/terraform.yml)