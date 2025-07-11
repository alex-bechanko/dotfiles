let
  keys.personal.tyr = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILj4k/4XkZxwhcyv4vNTRqGK8VBAecOA2NCEifYROKJu alexbechanko@gmail.com";
  keys.hosts.tyr = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF+gTD/l+BbKUj1yggyDLQGgFmmWi5cdETJtqHaaROOg root@tyr";
in {
  "gemini_api_key.age" = {
    publicKeys = [ keys.personal.tyr keys.hosts.tyr ];
  };
}
