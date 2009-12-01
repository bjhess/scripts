require 'rexml/document'
include REXML

queue_doc = Document.new(File.new("QueueRSS.xml"))
queue_root = queue_doc.root

aFile = File.new("netflix_queue_titles.txt", 'w')
queue_root.each_element('channel/item') { |item| 
#  puts item.elements['title'].text
  aFile.puts(item.elements['title'].text)
}  

aFile.close

