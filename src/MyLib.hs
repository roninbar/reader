{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE InstanceSigs     #-}

module MyLib (Reader (..)) where

newtype Reader s a = Reader { runReader :: s -> a }

instance Functor (Reader s) where
  fmap :: (a -> b) -> Reader s a -> Reader s b
  fmap g (Reader r) = Reader (g . r)

instance Applicative (Reader s) where
  pure :: a -> Reader s a
  pure x = Reader (const x)
  (<*>) :: Reader s (a -> b) -> Reader s a -> Reader s b
  rab <*> ra = Reader (\s -> runReader rab s (runReader ra s))

instance Monad (Reader s) where
  (>>=) :: Reader s a -> (a -> Reader s b) -> Reader s b
  ra >>= g = Reader (\s -> runReader (g (runReader ra s)) s)

