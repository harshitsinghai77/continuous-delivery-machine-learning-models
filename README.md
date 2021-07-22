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
