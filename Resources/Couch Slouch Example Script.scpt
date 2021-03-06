FasdUAS 1.101.10   ��   ��    k             l      ��  ��   

Couch Slouch AppleScript Example
======================

This script provides a quick demo of scripting Couch Slouch's
Behaviours feature. Using this script bridge, you can perform
custom actions when various actions occur on the connected TV.

See below for the available actions. Functions must be
named the same as they are here to be triggered correctly
by Couch Slouch.

IMPORTANT: These functions are executed asynchronously from
Couch Slouch but serially � that is, Couch Slouch remains
responsive while the script is running to allow button presses
to still work, but only one function will be executed at a time. If
your function takes a long time to run, consider launching a
separate process and returning quickly to allow other functions
to run in a timely manner.

     � 	 	 
 
 C o u c h   S l o u c h   A p p l e S c r i p t   E x a m p l e 
 = = = = = = = = = = = = = = = = = = = = = = 
 
 T h i s   s c r i p t   p r o v i d e s   a   q u i c k   d e m o   o f   s c r i p t i n g   C o u c h   S l o u c h ' s 
 B e h a v i o u r s   f e a t u r e .   U s i n g   t h i s   s c r i p t   b r i d g e ,   y o u   c a n   p e r f o r m 
 c u s t o m   a c t i o n s   w h e n   v a r i o u s   a c t i o n s   o c c u r   o n   t h e   c o n n e c t e d   T V . 
 
 S e e   b e l o w   f o r   t h e   a v a i l a b l e   a c t i o n s .   F u n c t i o n s   m u s t   b e 
 n a m e d   t h e   s a m e   a s   t h e y   a r e   h e r e   t o   b e   t r i g g e r e d   c o r r e c t l y 
 b y   C o u c h   S l o u c h . 
 
 I M P O R T A N T :   T h e s e   f u n c t i o n s   a r e   e x e c u t e d   a s y n c h r o n o u s l y   f r o m 
 C o u c h   S l o u c h   b u t   s e r i a l l y      t h a t   i s ,   C o u c h   S l o u c h   r e m a i n s 
 r e s p o n s i v e   w h i l e   t h e   s c r i p t   i s   r u n n i n g   t o   a l l o w   b u t t o n   p r e s s e s 
 t o   s t i l l   w o r k ,   b u t   o n l y   o n e   f u n c t i o n   w i l l   b e   e x e c u t e d   a t   a   t i m e .   I f 
 y o u r   f u n c t i o n   t a k e s   a   l o n g   t i m e   t o   r u n ,   c o n s i d e r   l a u n c h i n g   a 
 s e p a r a t e   p r o c e s s   a n d   r e t u r n i n g   q u i c k l y   t o   a l l o w   o t h e r   f u n c t i o n s 
 t o   r u n   i n   a   t i m e l y   m a n n e r . 
 
   
  
 l     ��������  ��  ��        i         I      �������� $0 couchslouch_tvon CouchSlouch_TVOn��  ��    k            l     ��  ��    ) # Called when the TV is switched on.     �   F   C a l l e d   w h e n   t h e   T V   i s   s w i t c h e d   o n .      l     ��������  ��  ��        I    ��  
�� .sysodlogaskr        TEXT  m        �   . T h e   T V   w a s   s w i t c h e d   o n !  ��  
�� 
btns  J          !�� ! m     " " � # #  O K��    �� $��
�� 
dflt $ m     % % � & &  O K��     '�� ' l   ��������  ��  ��  ��     ( ) ( l     ��������  ��  ��   )  * + * i     , - , I      �������� &0 couchslouch_tvoff CouchSlouch_TVOff��  ��   - k      . .  / 0 / l     �� 1 2��   1 * $ Called when the TV is switched off.    2 � 3 3 H   C a l l e d   w h e n   t h e   T V   i s   s w i t c h e d   o f f . 0  4 5 4 l     ��������  ��  ��   5  6 7 6 I    �� 8 9
�� .sysodlogaskr        TEXT 8 m      : : � ; ; 0 T h e   T V   w a s   s w i t c h e d   o f f ! 9 �� < =
�� 
btns < J     > >  ?�� ? m     @ @ � A A  O K��   = �� B��
�� 
dflt B m     C C � D D  O K��   7  E�� E l   ��������  ��  ��  ��   +  F G F l     ��������  ��  ��   G  H I H i     J K J I      �������� D0  couchslouch_becameactivetvsource  CouchSlouch_BecameActiveTVSource��  ��   K k      L L  M N M l     �� O P��   O 6 0 Called when the Mac became the active TV source    P � Q Q `   C a l l e d   w h e n   t h e   M a c   b e c a m e   t h e   a c t i v e   T V   s o u r c e N  R S R l     �� T U��   T 5 / (i.e., you can see the Mac's output on the TV)    U � V V ^   ( i . e . ,   y o u   c a n   s e e   t h e   M a c ' s   o u t p u t   o n   t h e   T V ) S  W X W l     ��������  ��  ��   X  Y Z Y I    �� [ \
�� .sysodlogaskr        TEXT [ m      ] ] � ^ ^ J T h i s   M a c   b e c a m e   t h e   a c t i v e   T V   s o u r c e ! \ �� _ `
�� 
btns _ J     a a  b�� b m     c c � d d  O K��   ` �� e��
�� 
dflt e m     f f � g g  O K��   Z  h�� h l   ��������  ��  ��  ��   I  i j i l     ��������  ��  ��   j  k l k i     m n m I      �������� @0 couchslouch_lostactivetvsource CouchSlouch_LostActiveTVSource��  ��   n k      o o  p q p l     �� r s��   r < 6 Called when the Mac is no longer the active TV source    s � t t l   C a l l e d   w h e n   t h e   M a c   i s   n o   l o n g e r   t h e   a c t i v e   T V   s o u r c e q  u v u l     �� w x��   w ? 9 (i.e., the user switched input source away from the Mac)    x � y y r   ( i . e . ,   t h e   u s e r   s w i t c h e d   i n p u t   s o u r c e   a w a y   f r o m   t h e   M a c ) v  z { z l     ��������  ��  ��   {  | } | I    �� ~ 
�� .sysodlogaskr        TEXT ~ m      � � � � � V T h i s   M a c   i s   n o   l o n g e r   t h e   a c t i v e   T V   s o u r c e !  �� � �
�� 
btns � J     � �  ��� � m     � � � � �  O K��   � �� ���
�� 
dflt � m     � � � � �  O K��   }  ��� � l   ��������  ��  ��  ��   l  � � � l     ��������  ��  ��   �  � � � i     � � � I      �������� ,0 couchslouch_macawoke CouchSlouch_MacAwoke��  ��   � k      � �  � � � l     �� � ���   � C = Called when the Mac either awakes from sleep or Couch Slouch    � � � � z   C a l l e d   w h e n   t h e   M a c   e i t h e r   a w a k e s   f r o m   s l e e p   o r   C o u c h   S l o u c h �  � � � l     �� � ���   �  is launched at startup    � � � � , i s   l a u n c h e d   a t   s t a r t u p �  � � � l     ��������  ��  ��   �  � � � I    �� � �
�� .sysodlogaskr        TEXT � m      � � � � �  T h i s   M a c   a w o k e ! � �� � �
�� 
btns � J     � �  ��� � m     � � � � �  O K��   � �� ���
�� 
dflt � m     � � � � �  O K��   �  ��� � l   ��������  ��  ��  ��   �  � � � l     ��������  ��  ��   �  ��� � i     � � � I      �������� ,0 couchslouch_macslept CouchSlouch_MacSlept��  ��   � k      � �  � � � l     �� � ���   � 8 2 Called when the Mac either sleeps or is shut down    � � � � d   C a l l e d   w h e n   t h e   M a c   e i t h e r   s l e e p s   o r   i s   s h u t   d o w n �  � � � l     ��������  ��  ��   �  � � � I    �� � �
�� .sysodlogaskr        TEXT � m      � � � � �  T h i s   M a c   s l e p t ! � �� � �
�� 
btns � J     � �  ��� � m     � � � � �  O K��   � �� ���
�� 
dflt � m     � � � � �  O K��   �  ��� � l   ��������  ��  ��  ��  ��       �� � � � � � � ���   � �������������� $0 couchslouch_tvon CouchSlouch_TVOn�� &0 couchslouch_tvoff CouchSlouch_TVOff�� D0  couchslouch_becameactivetvsource  CouchSlouch_BecameActiveTVSource�� @0 couchslouch_lostactivetvsource CouchSlouch_LostActiveTVSource�� ,0 couchslouch_macawoke CouchSlouch_MacAwoke�� ,0 couchslouch_macslept CouchSlouch_MacSlept � �� ��~ � ��}�� $0 couchslouch_tvon CouchSlouch_TVOn�  �~   �   �  �| "�{ %�z�y
�| 
btns
�{ 
dflt�z 
�y .sysodlogaskr        TEXT�} ���kv��� OP � �x -�w�v � ��u�x &0 couchslouch_tvoff CouchSlouch_TVOff�w  �v   �   �  :�t @�s C�r�q
�t 
btns
�s 
dflt�r 
�q .sysodlogaskr        TEXT�u ���kv��� OP � �p K�o�n � ��m�p D0  couchslouch_becameactivetvsource  CouchSlouch_BecameActiveTVSource�o  �n   �   �  ]�l c�k f�j�i
�l 
btns
�k 
dflt�j 
�i .sysodlogaskr        TEXT�m ���kv��� OP � �h n�g�f � ��e�h @0 couchslouch_lostactivetvsource CouchSlouch_LostActiveTVSource�g  �f   �   �  ��d ��c ��b�a
�d 
btns
�c 
dflt�b 
�a .sysodlogaskr        TEXT�e ���kv��� OP � �` ��_�^ � ��]�` ,0 couchslouch_macawoke CouchSlouch_MacAwoke�_  �^   �   �  ��\ ��[ ��Z�Y
�\ 
btns
�[ 
dflt�Z 
�Y .sysodlogaskr        TEXT�] ���kv��� OP � �X ��W�V � ��U�X ,0 couchslouch_macslept CouchSlouch_MacSlept�W  �V   �   �  ��T ��S ��R�Q
�T 
btns
�S 
dflt�R 
�Q .sysodlogaskr        TEXT�U ���kv��� OP ascr  ��ޭ