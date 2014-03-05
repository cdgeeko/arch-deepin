# Maintainer: Xu Fasheng <fasheng.xu[AT]gmail.com>
# Contributor: Josip Ponjavic <josipponjavic at gmail dot com>

pkgname=python2-deepin-storm
pkgver={% pkgver %}
pkgrel=1
arch=('any')
url="http://linuxdeepin.com/"
license=('GPL3')
pkgdesc="Python Storm is download library and tool for Linux Deepin project."
depends=('python2' 'python2-gevent')
makedepends=('python2-setuptools' 'intltool')

_fileurl={% fileurl %}
source=("${_fileurl}")
md5sums=('{% md5 %}')

_filename="$(basename "${_fileurl}")"
_filename="${_filename%.tar.gz}"
_innerdir="${_filename/_/-}"

_install_copyright_and_changelog() {
    mkdir -p "${pkgdir}/usr/share/doc/${pkgname}"
    cp -f debian/copyright "${pkgdir}/usr/share/doc/${pkgname}/"
    gzip -c debian/changelog > "${pkgdir}/usr/share/doc/${pkgname}/changelog.gz"
}

prepare() {
    cd "${srcdir}/${_innerdir}"

    # fix python version
    find -iname "*.py" | xargs sed -i 's=\(^#! */usr/bin.*\)python=\1python2='
}

package() {
    cd "${srcdir}/${_innerdir}"
    python2 setup.py install --root="${pkgdir}"
    _install_copyright_and_changelog
}