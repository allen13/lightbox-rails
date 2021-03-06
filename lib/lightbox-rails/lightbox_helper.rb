module LightboxRails
  module LightboxHelper
    # Takes the photo gallery at +dir+, with the name +name+, and creates a
    # Lightbox 2 group from them. Within +dir+ there may be a directory named
    # <tt>thumbs</tt> containing the respective thumbnails for each image.
    def lightbox_group(name, dir)
      images = Dir[File.join(dir, "*.{jpg,JPG,png,PNG,gif,GIF}")].
               sort { |a, b| image_name(a).to_i <=> image_name(b).to_i }

      singles = images.each_with_index.map do |f, i|
        filename = File.join("/", "assets", f.split(File::SEPARATOR)[-3..-1])
        thumbname = File.exists?(thumbs_path f) \
                    ? thumbs_path(filename)
                    : filename

        title = "#{i + 1} of #{images.size}"
        cls = "single" + {0 => " first", images.size - 1 => " last"}[i] || ""

        content_tag(:div, :class => cls) do
          content_tag(:a,
                      :class => "lightbox[#{name.downcase.gsub(" ", "-")}]",
                      href: filename) do
            image_tag thumbname, alt: title, size: "100x100"
          end
        end
      end

      lightbox_set singles
    end

    private

    # Returns the basename of an image without its file extension.
    #
    #   image_name "/path/to/name_of_image.jpg"  # => "name_of_image"
    def image_name(image)
      File.basename image, "*.{jpg,JPG,png,PNG,gif,GIF}"
    end

    # Collects +singles+, an array of Lightbox 2 singles, into an image
    # row/set.
    def lightbox_set(singles)
      content_tag(:div, :class => "image-row") do
        content_tag(:div, :class => "set") do
          singles.map { |s| concat s }
        end
      end
    end

    # Takes the image at +path+ and returns the path to the thumbnail for that
    # image, assuming that the thumbnail has the same filename and resides in
    # a child directory named <tt>thumbs</tt>.
    #
    #   thumbs_path "/path/to/image.jpg"  # => "/path/to/thumbs/image.jpg"
    def thumbs_path(path)
      File.join File.dirname(path), "thumbs", File.basename(path)
    end
  end
end
