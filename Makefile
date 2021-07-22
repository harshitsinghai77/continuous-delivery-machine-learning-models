check_inference:
	curl -X POST  -H "Content-Type: application/json" \
	--data '["Containers are more or less interesting"]' \
	http://0.0.0.0:5000/predict

	curl -X POST  -H "Content-Type: application/json" \
	--data '["MLOps is critical for robustness"]' \
	http://0.0.0.0:5000/predict
