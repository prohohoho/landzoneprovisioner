import os
from github import GithubIntegration, Auth
# GitHub App ID and private key

# GitHub repository details
owner = os.environ.get("GITHUB_REPOSITORY_OWNER")
repo = os.environ.get("REPO_NAME")

# GitHub App ID and private key
app_id = os.environ.get("TF_VAR_GITHUB_APP_ID")
private_key = os.environ.get("TF_VAR_GITHUB_APP_PEM")

# Create a GitHub integration object
integration = GithubIntegration(auth=Auth.AppAuth(app_id=app_id, private_key=private_key))
# Get an installation access token
installation_id = integration.get_repo_installation(owner, repo)
access_token = integration.get_access_token(installation_id.id).token

print(access_token)