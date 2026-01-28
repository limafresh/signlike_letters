from PIL import Image, ImageDraw, ImageFont
import string
import os

output_dir = "../textures"
os.makedirs(output_dir, exist_ok=True)

font_path = "/usr/share/fonts/opentype/Aileron/Aileron-Regular.otf"
canvas_size = 128
font_size = 128
font = ImageFont.truetype(font_path, font_size)


def render_letter(letter, filename):
    img = Image.new("RGBA", (canvas_size, canvas_size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    bbox = draw.textbbox((0, 0), letter, font=font)
    w = bbox[2] - bbox[0]
    h = bbox[3] - bbox[1]

    x = (canvas_size - w) // 2 - bbox[0]
    y = (canvas_size - h) // 2 - bbox[1]

    draw.text((x, y), letter, font=font, fill=(255, 255, 255, 255))
    img.save(os.path.join(output_dir, filename))


for letter in string.ascii_uppercase:
    render_letter(letter, f"{letter.lower()}.png")
