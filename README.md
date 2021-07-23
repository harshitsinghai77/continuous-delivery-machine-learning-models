## Create .env

```terminal
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

## Download model

[https://github.com/onnx/models/tree/master/text/machine_comprehension/roberta](https://github.com/onnx/models/tree/master/text/machine_comprehension/roberta)

Go to the ^ repository and download `roberta-sequence-classification-9.onnx` model.

Place the downloaded model inside the /webapp/ dir.

## Build Docker

`docker build -t deploy/roberta .`

## Run the container
Run the container locally to interact with it in the same way as when running the application directly with Python. Remember to map the ports of the container to the localhost:

`docker run -it -p 5000:5000 --rm deploy/roberta`

## Check inference

Once deployed and the container is running, try

```terminal
make check_inference
```

to check if the model is deployed and outputs a json result.

## Using Azure Machine Learning Studio

The contents of the project is pushed in Git repository without the ONNX model.

This is because the ML/DL model are usually very large and shouldn't be uploaded in a version control system. Git is not meant to handle versioning of binary files and has the side-effect of creating huge repositories because of this.

The ONNX model is uploaded at Azure Machine Learning Studio.

## These are the steps we have for packaging the RoBERTa-Sequence model:

1. Checkout the current branch of the repository
2. Authenticate to Azure Cloud
3. Configure auto-install of Azure CLI extensions
4. Attach the folder to interact with the workspace
5. Download the ONNX model
6. Build the container for the current repo

## Automated container deployment using Github Actions

Github Actions allows us to create a continuous delivery workflow in a YAML file, that gets triggered when configurable conditions are met. The idea is that whenever the repository has a change in the main branch, the platform will pull the registered model from Azure, create the container, and lastly, it will push it to a container registry.

## Use GitHub Actions with Azure Machine Learning

Since the ONNX model doesn’t exist locally, we need to retrieve it from Azure, so we must authenticate using the Azure action. After authentication, the az tool is made available, and we must attach the folder for my workspace and group. Finally, the job can retrieve the model by its ID.

Steps to configure Github Actions to pull the registered model from Azure.

Generate deployment credentials:

Go to Azure Cloud Shell

````
az ad sp create-for-rbac --name "myML" --role contributor --scopes /subscriptions/<subscription-id> resourceGroups/<group-name> --sdk-auth```
````

The output is a JSON object with the role assignment credentials that provide access to your App Service app similar to below. Copy this JSON object.

In GitHub, browse your repository, select Settings > Secrets > Add a new secret.
Paste the entire JSON output from the Azure CLI command into the secret's value field. Give the secret the name AZURE_CREDENTIALS.

## Automatically Publish the container to Docker Hub

Publish the container after it builds. Docker Hub support for Github Actions is straightforward, and all it requires is to create a token and then save it as a Github project secret, along with your Docker Hub username.

The container is packaged and distributing the ONNX model in a fully automated fashion by leveraging Github’s CI/CD offering and container registry. In this way, the process is segmented into small steps, and it allows any updates to be done to the container. Finally, the steps publish the container to a selected registry.
