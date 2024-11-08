from flask import Flask
import os

audio_filepath = os.getenv("AUDIO_FILEPATH")
if not audio_filepath:
    print("AUDIO_FILEPATH is not set")
    exit(1)

log_filepath = os.getenv("LOG_FILEPATH")
if not log_filepath:
    print("LOG_FILEPATH is not set")
    exit(1)

r = ""

try:
    from whisperspeech.pipeline import Pipeline
except Exception as e:
    with open(log_filepath, "w") as f:
        f.write(str(e))

port = 55005
app = Flask(__name__)

@app.route("/")
def hello_world():
    return 'Enter Python code and tap "Run".'

@app.route("/audio", methods=["POST"])
def generate_audio():
    try:
        tts_pipe = Pipeline(s2a_ref='collabora/whisperspeech:s2a-q4-tiny-en+pl.model') # uncomment the line for the model you want to use
        tts_pipe.generate_to_file(audio_filepath, r)

        return "Audio generated! The path: " + audio_filepath
    except Exception as e:
        with open(log_filepath, "w") as f:
            f.write(str(e))

        return "Error: " + str(e)

app.run(port=port)