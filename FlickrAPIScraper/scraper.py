import flickrapi as fapi 
import requests

# To apply for a Flickr API key, log into Flickr and see here:
# https://www.flickr.com/services/apps/create/apply
FLICKR_PUBLIC = "250d9d41cbb48b470e0e4407692b3692"
FLICKR_SECRET = "d9e680ba0fcb158c"

# Fill in the search terms here.
# Try https://www.indifferentlanguages.com
search_terms = ["hippopotamus", "Nilpferd"]

# Explanation of the "extras" tags:
# https://librdf.org/flickcurl/api/flickcurl-searching-search-extras.html
tag = "url_m"
num_results = 500 # The maximum Flickr will provide

for search_term in search_terms:
  print("Downloading images for:", search_term)
  
  # Go to Flickr and request the URLs of the images
  flickr = fapi.FlickrAPI(FLICKR_PUBLIC, FLICKR_SECRET, format="parsed-json")
  cats = flickr.photos.search(
    text=search_term,
    per_page=num_results,
    extras=tag
  )

  # Download each image into its own file.
  count = 0
  for p in cats["photos"]["photo"]:
    if tag in p:
        url = p[tag]
        response = requests.get(url, stream=True)
        if not response.ok:
            print(response)
        else:
          try:
            f = open("images/" + search_term + "_image_" + str(count) + ".jpg", "wb")
            for block in response.iter_content(1024):
              if not block:
                break
              f.write(block)
          except:
            pass
          finally:
            f.close()
        count += 1
        if count % 100 == 0:
            print("    ", count, "of", num_results)

