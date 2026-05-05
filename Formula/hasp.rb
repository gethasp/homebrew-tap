class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.1"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.1/hasp_1.0.1_darwin_arm64.tar.gz"
      sha256 "8fc6d057efef6628ee77fc9fb0594e28f3d99e6da2f716d5e533a586c0f6e940"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.1/hasp_1.0.1_darwin_amd64.tar.gz"
      sha256 "0c4c2295ed28024ef6a5fa95ecdffed1965f6a5312a00da8e81090a690702593"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.1/hasp_1.0.1_linux_arm64.tar.gz"
      sha256 "c1327b215e794b9d6c1f4dd18b0ca0cb6afe119b9b10126b7e06a428b93df9cd"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.1/hasp_1.0.1_linux_amd64.tar.gz"
      sha256 "db50aa3fcb2421ee51a63c4ec183b04ee75b92ceb42ad07be5c2573fed35c844"
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
