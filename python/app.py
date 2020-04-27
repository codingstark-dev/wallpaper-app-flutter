# from bs4 import BeautifulSoup
import requests
import praw
import json
import time
from firebase import firebase
from io import BytesIO
from PIL import Image

reddit = praw.Reddit(client_id='W1XGqNQSKF2h4w',
                     client_secret='32CM4A9gSaIGVJFTwCHtKjWt7Xg', password='6b6WNmT*qZQ@qvx',
                     user_agent='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.113 Safari/537.36', username='himanshu338')
subreddit = reddit.subreddit('Amoledbackgrounds')
hot_python = subreddit.new(limit=10)

firebase = firebase.FirebaseApplication(
    'https://wallpaper-277ec.firebaseio.com/', None)

listfile = []


def redditdatas():
    for submission in hot_python:
        if submission.url.lower().lower().endswith(('.png', '.jpeg', '.jpg')):
            url = requests.head(submission.url, headers={
                'User-agent': 'your bot 0.1'})
            if url.status_code == 200:
                # print(submission.preview)
                url2 = submission.url
                filename = submission.title
                author = str(submission.author)
                ups = submission.ups
                created_utc = submission.created_utc
                permalink = submission.permalink
                preview = str(submission.preview['images'][0]['resolutions'][2]['url']).replace(
                    "amp", "")
                wallpaperpreview = str(submission.preview['images'][0]['resolutions'][3]['url']).replace(
                    "amp", "")
                image_data = BytesIO(requests.get(url2).content)

                image_obj = Image.open(image_data)
                raw_image_data = str(image_obj)
                url.headers['Content-Length']
                imagebytes = url.headers['Content-Length']
                imagesize = image_obj.size

                listfile.append({
                    "image": url2,
                    "title": filename,
                    "author": author,
                    "ups": ups,
                    "created_utc": created_utc,
                    "permalink": permalink,
                    "preview": preview,
                    "wallpaper": wallpaperpreview,
                    "imagesize": imagesize, "imagebytes": imagebytes})
                # if "blue" in filename:
                #     print(filename)
                time.sleep(1)


redditdatas()
with open("sample.json", "w") as outfile:
    json.dump(listfile, outfile)

firebase.put('/newwallpaper/', data=listfile, name="new",)

print("DONE")
# r = requests.get(url)
# if r.status_code == 200:
# if url.endswith(".png"):
#     with open(filename+'.png', 'wb') as f:
#         f.write(r.content)
# elif url.endswith(".jpg"):
#     with open(filename+'.jpg', 'wb') as f:
#         f.write(r.content)
# elif url.endswith(".jpeg"):
#     with open(filename+'.jpeg', 'wb') as f:
#         f.write(r.content)


# redditdatas()
# print(len(listfile))
