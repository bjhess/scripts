require 'rexml/document'
include REXML

posts_doc = Document.new(File.new("notesdb.xml"))
posts_root = posts_doc.root

post2cat_doc = Document.new(File.new("wp_post2cat.xml"))
post2cat_root = post2cat_doc.root

cats_doc = Document.new(File.new("wp_categories.xml"))
cats_root = cats_doc.root

posts_root.each_element('wp_posts') { |post| 
  #puts post.elements['post_content'].text
  aFile = File.new("files/#{post.elements['post_title'].text}.txt", 'w') 
  aFile.puts(post.elements['post_content'].text)
  
  aFile.close
}

def get_file_suffix(post)
  post_id = post.elements['ID'].text
  #case 
end