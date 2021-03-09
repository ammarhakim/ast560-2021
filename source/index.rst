AST560: Computational Plasma Physics 2021
+++++++++++++++++++++++++++++++++++++++++

These are slides, notes and other materials for AST560 Spring 2021
course for the portion of the class taught by Ammar Hakim. These
lectures focus on finite-volume and discontinuous Galerkin schemes for
partial differential equations (PDEs), specifically fluid mechanics
(Euler equations) and plasma physics (MHD equations, multi-fluid
equations and the Vlasov-Maxwell system). We will look at schemes
suited to shock dominated flows rather than problems on resistive
time-scales. Vast majority of laboratory, space and astrophysical
problems have complex interactions of shocks, turbulence and magnetic
fields and the schemes in these lectures will help you solve equation
to study such phenomena.

The final couple of lectures will be an introduction to implicit
methods to solve and couple diffusive and other non-ideal physics to
hyperbolic PDE solvers.

.. contents::

Lecture 1: Hyperbolic PDEs and Finite-Volume Methods I
------------------------------------------------------

`PDF of Lecture 1 slides <./_static/lec1.pdf>`_

As reading for this and the next lectures please read Chapters 1, 2, 3
and 5 in [LeVeque1992]_. Some notes and references to material not
completely covered in class:

- van Dyke's "Album of Fluid Motion" is an excellent source of
  beautiful pictures of fluid flow. See `this link for a PDF of an
  older version
  <http://courses.washington.edu/me431/handouts/Album-Fluid-Motion-Van-Dyke.pdf>`_
  of the book.
- See eigensystem of Euler equations listed `here
  <http://ammar-hakim.org/sj/euler-eigensystem.html>`_ and Maxwell
  equations `here
  <http://ammar-hakim.org/sj/maxwell-eigensystem.html>`_.
- For ideal MHD equations the eigensystem is very complex. A listing
  is in [RyuJones1995]_ but it may be a good idea to rederive this and
  cross-check.

References
----------

.. [RyuJones1995] Ryu, Dongsu and Jones, T.W. "Numerical
   Magnetohydrodynamics in Astrophysics: algorithms and tests for
   one-dimensional flow", *Astrophysical Journal*, **442** 228-258,
   1995. `PDF <./_static/1995ApJ___442__228R.pdf>`_

.. [LeVeque1992] R.J. LeVeque. "Numerical methods for conservation
   laws". Birkhäuser, 1992.	 
