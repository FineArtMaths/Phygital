import flickrapi as fapi 
import requests

# To apply for a Flickr API key, log into Flickr and see here:
# https://www.flickr.com/services/apps/create/apply
FLICKR_PUBLIC = "REDACTED"
FLICKR_SECRET = "REDACTED"

# Fill in the search term and number of results here.
search_term = "hippo"
num_results = 20

# Explanation of the "extras" tags:
# https://librdf.org/flickcurl/api/flickcurl-searching-search-extras.html
tag = "url_m"

# Go to Flickr and request the URLs of the images
flickr = fapi.FlickrAPI(FLICKR_PUBLIC, FLICKR_SECRET, format="parsed-json")
cats = flickr.photos.search(
  text=search_term,
  per_page=num_results,
  extras=tag
)

# Download each image into its own file.
# If requesting a large number of images, it would be
# wise to "throttle" this part of the process to avoid
# gettting an IP ban from Flickr. 
count = 0
for p in cats["photos"]["photo"]:
  url = p[tag]
  f = open("images/image_" + str(count) + ".jpg", "wb")
  response = requests.get(url, stream=True)
  if not response.ok:
      print(response)
  else:
    for block in response.iter_content(1024):
      if not block:
        break
      f.write(block)
  f.close()
  count += 1
