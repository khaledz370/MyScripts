from gimpfu import *

def resize_and_export(image, drawable):
    # Define the sizes you want to export
    sizes = [(16, 16), (48, 48), (128, 128)]

    # Get the base filename
    base_filename = image.filename
    base_filename = base_filename.rsplit('.', 1)[0]  # Remove the extension

    for width, height in sizes:
        # Duplicate the image
        image_copy = pdb.gimp_image_copy(image)
        drawable_copy = pdb.gimp_image_get_active_layer(image_copy)

        # Resize the image
        pdb.gimp_image_scale(image_copy, width, height)

        # Export the image
        export_filename = f"{base_filename}_{width}x{height}.png"
        pdb.file_png_save_defaults(image_copy, drawable_copy, export_filename, export_filename)

        # Clean up
        pdb.gimp_image_delete(image_copy)

register(
    "python-fu-resize-export",
    "Resize and export image to multiple sizes",
    "Resize and export image to 16x16, 48x48, and 128x128",
    "Your Name", "Your Name", "2024",
    "Resize and Export...",
    "*", [
        (PF_IMAGE, "image", "Input image", None),
        (PF_DRAWABLE, "drawable", "Input drawable", None),
    ],
    [],
    resize_and_export,
    menu="<Image>/File/Create")

main()
