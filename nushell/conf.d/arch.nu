#!/usr/bin/env nu

let ostype: string = (uname | get kernel-name)

match $ostype {
  "Linux" => {
    let distro: string = (cat /etc/os-release | lines | parse "{key}={value}" | where key == PRETTY_NAME | get value | get 0)
    print ('Detected Linux distribution: ' + $distro)
    source arch/linux.nu
  }
  "Darwin" => {
    print 'Detected macOS operating system.'
  }
  "Windows_NT" => {
    print 'Detected Windows operating system.'
    source arch/windows.nu
  }
  _ => {
    print 'Operating system $ostype is not specifically handled.'
  }
}
