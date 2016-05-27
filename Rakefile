require "rake"
require "rake/clean"

CHAPTERS_DIR = "chapters"
CHAPTER_FILES = Rake::FileList.new("#{CHAPTERS_DIR}/*.md")
FIGURES_DIR = "figures"
IMAGES_DIR = "images"
MAIN_TEX_FILE = "layout.tex"
BUILD_DIR = "build"
TARGET_PDF = "diploma.pdf"

task chapters: CHAPTER_FILES.ext(".tex")
task default: [:chapters, :typeset]
 
rule ".tex" => ->(f){source_for(f)} do |t|
  sh "bin/md_to_tex #{t.source} | bin/recite | bin/resection > #{t.name}"
  Rake::Task[:typeset].execute
end

task :typeset do
  mkdir_p BUILD_DIR
  cp MAIN_TEX_FILE, BUILD_DIR
  cp Dir.glob("*.{bib,bst,xmp,xmpi,icm}"), BUILD_DIR
  cp_r CHAPTERS_DIR, BUILD_DIR
  cp_r FIGURES_DIR, BUILD_DIR
  cp_r IMAGES_DIR, BUILD_DIR
  Dir.chdir(BUILD_DIR) do
    sh "latexmk -pdf -recorder"
  end
  mv File.join(BUILD_DIR, MAIN_TEX_FILE.ext(".pdf")), TARGET_PDF
end
 
def source_for(src_file)
  CHAPTER_FILES.find { |f| f.ext("") == src_file.ext("") }
end

CLEAN.include(Dir.glob(File.join(CHAPTERS_DIR,"*.aux")))
CLEAN.include(File.join(BUILD_DIR, "*"))

CLOBBER.include(TARGET_PDF)
CLOBBER.include(Dir.glob(File.join(CHAPTERS_DIR,"*.tex")))

# # Test Suite
#
# Run with:
#
#     $ ruby Rakefile
#
if __FILE__ == $0
  require "minitest/autorun"

  class Tests < MiniTest::Test
    def test_haha
      assert_equal 1, 1
    end
  end
end
