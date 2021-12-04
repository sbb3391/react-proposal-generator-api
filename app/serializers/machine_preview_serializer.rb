class MachinePreviewSerializer < SerializerParent
  attributes :id, :assemblies, :image_url, :image_key

  def return_assemblies
    serialize_machine_preview_assemblies(self.object)
  end

  # unique key for machine
  def get_image_key
    return_image_key({assemblies: return_assemblies})
  end

  def assemblies 
    return_assemblies
  end

  def image_url
    image = Image.find_by(image_key: image_key)
    image ? image[:image_url]: nil 
  end

  def image_key
    get_image_key
  end
end