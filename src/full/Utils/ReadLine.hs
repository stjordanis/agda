{-# OPTIONS -cpp #-}

{-| A wrapper for readline. Makes it easier to handle absence of readline.
-}
module Utils.ReadLine where

import qualified System.Console.Readline as RL
import System.IO

import Utils.Unicode
import Utils.Monad

readline   :: String -> IO (Maybe String)
addHistory :: String -> IO ()
#ifdef mingw32_HOST_OS
readline s = do
  putStr s
  hFlush stdout
  l <- getLine
  return $ Just $ fromUTF8 l
addHistory s = return ()
#else
readline   s = fmap fromUTF8 <$> RL.readline s
addHistory s = RL.addHistory $ toUTF8 s
#endif
