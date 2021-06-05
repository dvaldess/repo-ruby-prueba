# Definiendo las librerias necesarias

require 'uri'
require 'net/http'
require 'json'

# Definiendo el primer metodo

def request(url,api_key)
  url = URI("#{url}&api_key=#{api_key}")
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true
  request = Net::HTTP::Get.new(url)
  response = https.request(request)
  response.read_body 
  return JSON.parse(response.read_body)
end

# Definiendo la variable que utilizará la URL y la API Key personal

dato = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10","qHmSLGOJIcqxOlkFKLvm1Akz6fKIBf6lv12mwv0T")

# Para validar
# puts dato

# Definiendo el segundo metodo

def build_web_page(dato)
    photos = dato['photos'].map{|x| x['img_src']}
    html_inicio = "<html>\n<head>\n</head>\n<body>\n<ul>\n"
    body = ""
    html_fin = "</ul>\n</body>\n</html>"
    photos.each do |photo|
        body += "\t<img src=\"#{photo}\">\n" # \t tabulacion \s espacio \b backspace \n salto de linea
    end
    File.write('output.html', html_inicio + body + html_fin) # Guardando el resultado del segundo metodo en un html
end

# Llamando al metodo

build_web_page(dato)

# Definiendo el tercer metodo

def photos_count(dato)
  camera = dato['photos'].map{|x| x['name']}
  cantidad = (dato['photos'].map{|x| x['name']}).count
  pp "Son #{cantidad} Fotos"
end

# Llamando al metodo

photos_count(dato)