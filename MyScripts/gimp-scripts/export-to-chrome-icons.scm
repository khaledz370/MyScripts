(define (resize-and-export image drawable)
  (let* (
         ; Define the sizes you want to export
         (sizes '((16 16) (48 48) (128 128)))

         ; Get the base filename
         (base-filename (car (gimp-image-get-filename image)))
         (base-filename (string-append (car (string-split base-filename "."))
                                       "_"))
         )
    (for-each
     (lambda (size)
       (let* (
              (width (car size))
              (height (cadr size))
              (image-copy (car (gimp-image-copy image)))
              (drawable-copy (car (gimp-image-get-active-layer image-copy)))
              (export-filename (string-append base-filename (number->string width) "x" (number->string height) ".png"))
              )
         ; Resize the image
         (gimp-image-scale image-copy width height)

         ; Export the image
         (file-png-save-defaults image-copy drawable-copy export-filename export-filename)

         ; Clean up
         (gimp-image-delete image-copy)
         )
       )
     sizes)
    )
  )

(script-fu-register
 "resize-and-export"
 "Resize and export image to multiple sizes"
 "Resize and export image to 16x16, 48x48, and 128x128"
 "Your Name" "Your Name" "2024"
 "Resize and Export..."
 "*"
 '(
   (PF_IMAGE "image" "Input image" 0)
   (PF_DRAWABLE "drawable" "Input drawable" 0)
   )
 '()
 'resize-and-export
 )

(script-fu-menu-register "resize-and-export" "
/File/Create/Resize and Export")
