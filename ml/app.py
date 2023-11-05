import uvicorn
from fastapi import FastAPI, HTTPException
import requests
import io
from PIL import Image
import yolov5
from typing import Dict
import urllib.parse
app = FastAPI()


# https://upload.wikimedia.org/wikipedia/commons/3/3f/JPEG_example_flower.jpg

# load model
model = yolov5.load('keremberke/yolov5m-garbage')

# set model parameters
model.conf = 0.25  # NMS confidence threshold
model.iou = 0.45  # NMS IoU threshold
model.agnostic = False  # NMS class-agnostic
model.multi_label = False  # NMS multiple labels per box
model.max_det = 1000  # maximum number of detections per image


@app.get('/')
def index():
    return {'message': 'Hello, World'}


@app.post('/predict')
async def process_url(body: Dict[str, str]):

    # make a GET request to the URL
    url = body['url']
    img = url
    # print(img)
    # print("\n\n\n\n")

    results = model(img, size=640)

    # show detection bounding boxes on image
    # results.show()
    results = str(results)

    # print(results)  # results output image 1/1: 720x1280 2 biodegradables, 1 paper
    results = results.split('Speed:')[0]
    spr = results.split(' ')
    # spr = spr.split('\n')
    # print(results)

    # count the number of detected objects
    count = 0
    last_word = '0'
    for label in spr:

        label = label.strip().replace(",", "")
        # print(label)
        # label = label.strip().replace("\n", "")
        # print( " formatted lable --------------" +label)
        # print(label)
        if (label == "paper" or label == "papers"):
            count = count + int(last_word)
        elif (label == "rubber" or label == "rubbers"):
            count = count + int(last_word)
        elif (label == "plastics" or label == "plastic"):
            count = count + int(last_word)
            # print("loade lele")
        elif (label == "glass" or label == "glasses"):
            count = count + int(last_word)
            # print("loade lele")
        elif (label == "biodegradable"):
            count = count + int(last_word)
            # print("loade lele")
        elif(label=="cardboard" or label=="cardboards"):
            count= count + int(last_word);

        else:
            last_word = label
            # print("fcku")
            # print(last_word)
        # print(last_word)

    # print(" this is the value of count " + str(count))

    # return the result
    return {"message": count}


if __name__ == '__main__':
    uvicorn.run(app, host='0.0.0.0', port=10000)