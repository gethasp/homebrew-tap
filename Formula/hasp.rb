class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.13"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.13/hasp_0.1.13_darwin_arm64.tar.gz"
      sha256 "588088915d7cf039a04bbc67501ada4f68c73364458cef4cbdfe22b394b1209c"
    end
    on_intel do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.13/hasp_0.1.13_darwin_amd64.tar.gz"
      sha256 "9f0e65d16f8ea234649ea9cb600eda2327facc32ac9391f1fd8c04a787a8796d"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.13/hasp_0.1.13_linux_arm64.tar.gz"
      sha256 "40c1a16cb48aca7620d8483dd958c024c896b4e31b2627c0a1ba24a0ce0df790"
    end
    on_intel do
      url "https://github.com/gethasp/homebrew-tap/releases/download/v0.1.13/hasp_0.1.13_linux_amd64.tar.gz"
      sha256 "4f496e7589d74b17bd59f452582f19302b09135e28af5636e924a4b6a86f440a"
    end
  end
  def install
    libexec.install "bin"
    bin.install_symlink libexec/"bin/hasp"
    (pkgshare/"agent-profiles").install Dir["agent-profiles/*"]
    (pkgshare/"profiles").install Dir["profiles/*"]
    (pkgshare/"scripts").install Dir["scripts/*"]
    pkgshare.install "README.md", "QUICKSTART.md", "OPERATOR_GUIDE.md", "PRODUCTION_GUIDE.md", "RELEASE_MANIFEST", "LICENSE"
  end

  def caveats
    <<~EOS
      Add #{bin} to PATH if it is not already there.
      Set HASP_HOME and HASP_MASTER_PASSWORD before first use.
      Package docs and helper scripts are installed under: #{pkgshare}
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hasp version")
  end
end
