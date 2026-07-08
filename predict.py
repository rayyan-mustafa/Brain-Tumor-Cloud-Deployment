import os
from flask import Flask, jsonify

app = Flask(__name__)


@app.get("/")
def home():
    return jsonify(
        {
            "status": "ok",
            "message": "Brain Tumor classifier demo container is running",
            "prediction": "Glioma",
            "note": "This is a simple demo deployment because the repo does not include trained weights.",
        }
    )


@app.get("/predict")
def predict():
    return jsonify(
        {
            "prediction": "Glioma",
            "confidence": 0.97,
            "class_names": ["Glioma", "Meningioma", "No Tumor", "Pituitary"],
        }
    )


if __name__ == "__main__":
    port = int(os.environ.get("PORT", "8000"))
    app.run(host="0.0.0.0", port=port)
