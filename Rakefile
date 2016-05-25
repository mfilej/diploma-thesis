require "rake"
require "rake/clean"

CHAPTERS_DIR = "chapters"
CHAPTER_FILES = Rake::FileList.new("#{CHAPTERS_DIR}/*.md")
MAIN_TEX_FILE = "layout.tex"
BUILD_DIR = "build"
TARGET_PDF = "diploma.pdf"

task chapters: CHAPTER_FILES.ext(".tex")
task default: :chapters
 
rule ".tex" => ->(f){source_for(f)} do |t|
  sh "pandoc -f markdown_github+tex_math_dollars+raw_tex-hard_line_breaks -t latex #{t.source} | recite > #{t.name}"
  Rake::Task[:typeset].execute
end

task :typeset do
  mkdir_p BUILD_DIR
  rm_rf File.join(Dir.pwd, BUILD_DIR, "*")
  cp MAIN_TEX_FILE, BUILD_DIR
  cp Dir.glob("*.{bib,bst,xmp,xmpi,icm}"), BUILD_DIR
  cp_r CHAPTERS_DIR, BUILD_DIR
  Dir.chdir(BUILD_DIR) do
    sh "pdflatex -file-line-error -interaction=nonstopmode -synctex=1 #{MAIN_TEX_FILE}"
    sh "bibtex #{MAIN_TEX_FILE.ext(".aux")}"
    sh "pdflatex -file-line-error -interaction=nonstopmode -synctex=1 #{MAIN_TEX_FILE}"
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
