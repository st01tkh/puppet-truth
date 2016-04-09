class truth::enforcer {
  # Now conditionally include things based on properties and facts
  if has_role("loadbalancer") {
    # include loadbalancer
    notice("I am a loadbalancer")
  } else {
    notice("I am not a loadbalancer")
  }

  if has_role("db") {
    notice("I am a database")
  } else {
    notice("I am not a database")
  }

  ## Practical hadoop example --
  # You can even have logic here to reject configurations you 
  # say are invalid.
  if has_role("hadoop-worker") and has_role("hadoop-master") {
    fail("Cannot be both hadoop-worker and hadoop-master. \$server_tags is '$server_tags'")
  }

  # All non-hadoop machines should get a special config that makes them able to
  # send jobs to the hadoop cluster.
  if !has_role("hadoop-worker") and !has_role("hadoop-master") {
    notice("I am a hadoop client")
  }
  
  if has_role("hadoop-worker") {
    notice("I am a hadoop-worker")
  } else {
    notice("I am not a hadoop-worker")
  }

  if has_role("hadoop-master") {
    notice("I am a hadoop-master")
  } else {
    notice("I am not a hadoop-master")
  }

  if has_role("win_workstation_minimal") {
    notice("I am a Windows Workstation Minimal")
    include chocolatey
    Package { provider => 'chocolatey' }
    $packages = ['clink', 'conemu', 'googlechrome', 'clover', '7zip', 'git', 'vim', 'notepadplusplus']
    package { $packages: ensure => 'installed' }
  } else {
    notice("I am not a Windows Workstation Minimal")
  }
  if has_role("cygwin_common") {
    notice("I am a CygWin common")
    class {"cygwin_common": } ->
    class {"cygwin_ca_certificates": } ->
    class {"cygwin_apt_cyg": } ->
    class {"cygwin_git_encrypt": }
  } else {
    notice("I am not a CygWin common")
  }
}
