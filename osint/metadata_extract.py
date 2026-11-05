#!/usr/bin/env python3
"""Extract EXIF/metadata from images (requires Pillow)."""
import sys
from PIL import Image
from PIL.ExifTags import TAGS

def main(path):
    try:
        img = Image.open(path)
    except Exception as e:
        print(f"[!] Cannot open {path}: {e}")
        return

    print(f"File: {path}")
    print(f"Format: {img.format} | Size: {img.size} | Mode: {img.mode}")

    exif = img._getexif()
    if not exif:
        print("[i] No EXIF data found.")
        return

    interesting = {
        "Make": "Camera Make",
        "Model": "Camera Model",
        "DateTimeOriginal": "Original Date",
        "GPSInfo": "GPS Data",
        "Software": "Software",
        "Artist": "Author",
    }
    for tag_id, value in exif.items():
        tag = TAGS.get(tag_id, tag_id)
        if str(tag) in interesting:
            print(f"{interesting[str(tag)]}: {value}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <image>")
        sys.exit(1)
    main(sys.argv[1])
