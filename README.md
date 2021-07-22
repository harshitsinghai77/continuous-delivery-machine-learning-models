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

### Run the container locally to interact with it in the same way as when running the application directly with Python. Remember to map the ports of the container to the localhost:

`docker run -it -p 5000:5000 --rm deploy/roberta`

## Check inference

Once deployed and the container is running, try

```terminal
make check_inference
```

to check if the model is deployed and outputs a json result.

## Using Microsoft Azure for Machine Learning
The contents of the project is pushed in Git repository without the ONNX model.

This is because the ML/DL model are usually very large and shouldn't be uploaded in a version control system. Git is not meant to handle versioning of binary files and has the side-effect of creating huge repositories because of this.

The ONNX model is deployed in Microsoft Azure Machine Learning studio.

## Automated container deployment using Github Actions
Github Actions allows us to create a continuous delivery workflow in a YAML file, that gets triggered when configurable conditions are met. The idea is that whenever the repository has a change in the main branch, the platform will pull the registered model from Azure, create the container, and lastly, it will push it to a container registry.

