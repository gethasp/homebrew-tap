class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.4"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.4/hasp_0.1.4_darwin_arm64.tar.gz"
      sha256 "1616114048b83330ff4808478334a89570cc2263d95b183a8eb9f17e18a49e59"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.4/hasp_0.1.4_darwin_amd64.tar.gz"
      sha256 "480a2fe904a2dc24597667068b3ecbd3ff0ff4049ff26f90921518d2400cbf60"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.4/hasp_0.1.4_linux_arm64.tar.gz"
      sha256 "8170b4e44580bdf9280ce23e47ce7b6a1b6067cde1a0dd698a2de95dfe655234"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.4/hasp_0.1.4_linux_amd64.tar.gz"
      sha256 "e196532da2a901dc2c7a3cfc551f8a6dbb899b0b04e77177493bfce8b2d205c6"
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
