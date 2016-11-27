from PIL import Image, ImageDraw, ImageFont, ImageEnhance
from time import time
import os, sys
 
FONT = 'arial.ttf'

#usage e.g. python watermark.py apple.jpg ip=192.168.1.1 watermark.jpg 20 0.5
def add_watermark(in_file, text, out_file='watermark.jpg', angle=23, opacity=0.25):
    angle = int(angle)
    opacity = float(opacity)
    img = Image.open(in_file).convert('RGB')
    watermark = Image.new('RGBA', img.size, (0,0,0,0))
    size = 2
    n_font = ImageFont.truetype(FONT , size)
    n_width, n_height = n_font.getsize(text)
    while n_width+n_height < watermark.size[0]:
        size += 2
        n_font = ImageFont.truetype(FONT, size)
        n_width, n_height = n_font.getsize(text)
    draw = ImageDraw.Draw(watermark, 'RGBA')
    draw.text(((watermark.size[0] - n_width) / 2,
              (watermark.size[1] - n_height) / 2),
              text, fill=(0,0,0), font=n_font)
    watermark = watermark.rotate(angle,Image.BICUBIC)
    alpha = watermark.split()[3]
    alpha = ImageEnhance.Brightness(alpha).enhance(opacity)
    watermark.putalpha(alpha)
    Image.composite(watermark, img, watermark)
    #Image.composite(watermark, img, watermark).save(out_file, 'JPEG')
 
if __name__ == '__main__':
        t = time()
	add_watermark(*sys.argv[1:])
        print time() - t
