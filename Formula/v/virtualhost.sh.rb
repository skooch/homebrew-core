class VirtualhostSh < Formula
  desc "Script for macOS to create Apache virtual hosts"
  homepage "https://github.com/virtualhost/virtualhost.sh"
  # We use beta release as stable/1.x releases have no license
  url "https://github.com/virtualhost/virtualhost.sh/archive/refs/tags/2.0.0.beta2.tar.gz"
  sha256 "7413109605b7f1f508102216134738cbdd4e3b23b2dec85d89f63afd1ab34bdb"
  license "MIT"
  head "https://github.com/virtualhost/virtualhost.sh.git", branch: "2.x"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, all: "caf611d27d2f3391098872acc83c015efe68d7a267e5912d423a0bfd2d3e64e3"
  end

  def install
    bin.install "virtualhost.sh"
  end
end
