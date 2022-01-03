/// Get the full rootDomain for the specified [flag]
String getRootDomain(String flag) {
  switch (flag) {
    case 've':
      return 'vip.ve.atsign.zone';
    case 'prod':
    default:
      return 'root.atsign.org';
  }
}
