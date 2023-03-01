{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_TP (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/vodiniz/Prog/haskell_colors/.stack-work/install/x86_64-linux-tinfo6/a9890762d8c8a78ac4bcd83f9837ceea600a5b9c0fec4e946175b8f0d64bb13f/9.2.6/bin"
libdir     = "/home/vodiniz/Prog/haskell_colors/.stack-work/install/x86_64-linux-tinfo6/a9890762d8c8a78ac4bcd83f9837ceea600a5b9c0fec4e946175b8f0d64bb13f/9.2.6/lib/x86_64-linux-ghc-9.2.6/TP-0.1.0.0-5ajGVTevLteEUKciw51tS0-TP-exe"
dynlibdir  = "/home/vodiniz/Prog/haskell_colors/.stack-work/install/x86_64-linux-tinfo6/a9890762d8c8a78ac4bcd83f9837ceea600a5b9c0fec4e946175b8f0d64bb13f/9.2.6/lib/x86_64-linux-ghc-9.2.6"
datadir    = "/home/vodiniz/Prog/haskell_colors/.stack-work/install/x86_64-linux-tinfo6/a9890762d8c8a78ac4bcd83f9837ceea600a5b9c0fec4e946175b8f0d64bb13f/9.2.6/share/x86_64-linux-ghc-9.2.6/TP-0.1.0.0"
libexecdir = "/home/vodiniz/Prog/haskell_colors/.stack-work/install/x86_64-linux-tinfo6/a9890762d8c8a78ac4bcd83f9837ceea600a5b9c0fec4e946175b8f0d64bb13f/9.2.6/libexec/x86_64-linux-ghc-9.2.6/TP-0.1.0.0"
sysconfdir = "/home/vodiniz/Prog/haskell_colors/.stack-work/install/x86_64-linux-tinfo6/a9890762d8c8a78ac4bcd83f9837ceea600a5b9c0fec4e946175b8f0d64bb13f/9.2.6/etc"

getBinDir     = catchIO (getEnv "TP_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "TP_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "TP_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "TP_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "TP_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "TP_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
