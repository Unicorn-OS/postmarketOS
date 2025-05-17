# PMbootstrap may fail! If so: do it by hand

image_output = /home/me/.local/var/pmbootstrap/chroot_buildroot_aarch64/var/lib/postmarketos-android-recovery-installer/
image = pmos-amazon-karnak.zip

```
cd /home/me/.local/var/pmbootstrap/chroot_buildroot_aarch64/var/lib/postmarketos-android-recovery-installer/

# Example
image=pmos-amazon-karnak.zip

adb sideload $image  # pmos-amazon-karnak.zip
```
