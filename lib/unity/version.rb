class Unity
  # The major version of Unity, updated only for major changes that are
  # likely to require modification to Unity apps
  UnityMajorVersion = 0

  # The minor version of Unity, updated for new feature releases of Unity
  UnityMinorVersion = 1

  # The patch version of Unity, updated only for bug fixes from the last
  # feature release
  UnityPatchVersion = 0

  UnityVersion = "#{UnityMajorVersion}.#{UnityMinorVersion}.#{UnityPatchVersion}".freeze
end
