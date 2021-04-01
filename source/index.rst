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

As reading for the lectures please read Chapters 1, 2, 3 and 5 in
[LeVeque1992]_. Some notes and references to material not completely
covered in class:

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

In addition to the complexity of the physics and the mathematics of
numerical methods, computational physics software is very complex. In
addition to the physics itself being complicated (multiple spatial and
temporal scales, highly nonlinear physics, coupling between models,
huge number of unknowns, etc), the algorithms required may be
sophisticated, difficult to implement efficiently and may require
complex data-structures. In general, to achieve expertise in this
topic one needs to write a lot of code under the supervision of a
"Master Craftsman". It is hard to learn the real details of the field
any other way.

A nice summary of the concepts of the finite-volume schemes is given
in the paper `"A one-sided view" <./_static/Roe-60th.pdf>`_ by Roe,
LeVeque and van Leer.

.. contents::

Lecture Notes and Slides
------------------------

`Notes <./_static/fv-notes.pdf>`_ covering aspects of the
finite-volume schemes we covered in class. Work in progress!

- `Lecture 1 slides <./_static/lec1.pdf>`_
- `Lecture 2 slides <./_static/lec2.pdf>`_
- `Lecture 3 slides <./_static/lec3.pdf>`_
- `Lecture 4 slides <./_static/lec4.pdf>`_
- `Lecture 5 slides <./_static/lec5.pdf>`_
- `Lecture 6 slides <./_static/lec6.pdf>`_
- `Lecture 7 slides <./_static/lec7.pdf>`_

Homework
--------

.. figure:: ./_static/fivo-l-hacker.png
  :class: align-right
  :scale: 80%

  "Gacha Life" character drawn by Sophia Hakim (10 YO) to represent
  homework character Fivo L. Hacker ("Finite Volume Hacker").

My goal in setting homework is to review material covered in
class. Due to the pandemic forced remote learning it is hard to focus
and learn as much as one really should in a class like this. I hope
these homework sets allow a review of the material and improve
learning in these very trying and difficult situations.

- `Homework Set 1 <./_static/hw-part-1.pdf>`_

The Big Picture
---------------

To understand why computational methods have become central in plasma
physics we need to look at a few big-picture issues.

In particular:

- What are the cutting-edge research questions in computational plasma
  physics?

- What is the relationship between modern numerical methods and
  experiments and observations? (That is, why care about this stuff in
  the first place? Can simulations *predict* rather than *postdict*?)

- How to incorporate "real-world" effects into simulations? (For
  example, boundary conditions, atomic physics, etc)

One can look at computational physics in two ways: as an end in
itself, and as a tool for applications. Both of these are important!

As an end in itself:

- The first sits between applied mathematics and theoretical
  physics. The goal is to design efficient numerical methods to solve
  equations from theoretical physics.

- The goal here is the numerical method itself: what are its
  properties? Does it faithfully represent the underlying physics?
  Does it run efficiently on modern computers? Research into modern
  numerical methods (including structure preserving methods) fall into
  this category.

- Usually, besides the fun of solving complex equations (and writing
  code), the goal is to gain deeper understanding of underlying
  physics. **Some theoretical questions can only be answered with
  computer simulations.**

- This is a perfectly legitimate research area even if no connection
  to experiments is made, but only satisfies the curiosity of the
  researchers and helps one gain a better understanding of the
  physics.

As a tool for applications:

- The second is to look at the computational physics as providing
  tools to understand/design experiments or observations.

- Note that a large number of routine calculations are needed to build
  modern experiments (heat-transfer, structural analysis, basic fluid
  mechanics, equilibrium and stability calculations, etc). **Such
  routine calculations are no longer cutting edge research topics**.

At the intersection of cutting-edge computational physics and modern
plasma physics is a set of **Billion Dollar Questions**. (In general,
one should not put currency values to such things).

These **Billion Dollar Questions** need huge investments in
experimental and observational programs as well as the very latest in
computational physics research.

Space Physics Examples: Parker Solar Probe

- `Paker Solar Probe
  <https://www.nasa.gov/content/goddard/parker-solar-probe>`_. "The
  primary science goals for the mission are to **trace how energy and
  heat move through the solar corona** and to explore **what
  accelerates the solar wind** as well as **solar energetic
  particles**."

- The Probe will collect detailed measurements of electric and
  magnetic fields as well as detailed distribution functions of
  particles.

- The solar wind plasma is nearly collisionless. It is likely that a
  proper understanding of kinetic physics (at the level of the
  Vlasov-Maxwell equations) will be needed to fully understand the
  physical processes.

- Cutting-edge simulations will be critical to this. Serious research
  into numerics of Vlasov-Maxwell needs to be done and very large
  simulations need to be run.

Many other missions are active and planned: `BepiColombo
<https://en.wikipedia.org/wiki/BepiColombo>`_ to Mercury; `Juno
<https://en.wikipedia.org/wiki/Juno_(spacecraft)>`_ to Jupiter.

- Much of the deep understanding of plasma processes in solar system
  planets (magnetospheres, ionosphere) can only be gained from
  detailed modeling: global kinetic modeling is likely
  impossible. **How to incorporate some kinetic effects into fluid
  models?**

Fusion Physics Examples: Building a working thermonuclear fusion reactor.

- The `Iter project <https://www.iter.org>`_ aims to build the world's
  largest tokamak, a "magnetic bottle" to contain super-hot plasma and
  heat it to ignition temperatures.

There are other major fusion efforts around the world:

- `Beautiful stellarators <https://www.ipp.mpg.de/w7x>`_ (and `Wiki
  article <https://en.wikipedia.org/wiki/Wendelstein_7-X>`_) that may
  have better properties than tokamaks and provide a faster route to
  fusion energy

- `High-field based compact tokamaks
  <https://www.psfc.mit.edu/sparc>`_; `field-reversed configurations
  <https://tae.com>`_; spinning magnetic mirror machines; etc


There are major unsolved problems in the basic physics of fusion
machines. Most of these can only be answered by large-scale computing
and much of the numerical tools have not yet been fully developed.

The `Scientific Discovery through Advanced Computing
<https://www.scidac.org/partnerships/fusion-energy.html>`_ program in
fusion has large projects that address the very serious **Billion
Dollar Question**: will controlled fusion be eventually possible?

- The numerics research here is focused on gyrokinetic and even full
  kinetic understanding of fundamental turbulence and transport
  processes in the tokamak. **These equations are very difficult to
  solve!**

- Disruptions are dangerous processes that can "kill" certain fusion
  machine: large-scale MHD simulations are needed. Significant new
  research is being done in new numerical methods and application of
  existing MHD codes to such problems.

- Runaway electrons (relativistic high-energy electron beams) can
  drill holes in fusion machines. See `SCREAM project
  <https://scream.pppl.gov>`_ and `special PPCF issue
  <https://iopscience.iop.org/journal/0741-3335/page/Special-Issue-on-Runaway-Electrons>`_.

- Very serious! **Will need huge kinetic calculations**. Also, the
  formulation of self-consistent coupling between the runaway electrons
  and MHD is not complete. See review by [Boozer2015]_.

These are only selection of problems I am directly familiar with. I
hope it gives you a flavor and understanding why computational plasma
physics is such a serious and important field!

Potential Second-Year Theory or Thesis Projects
-----------------------------------------------

- Expanding box simulations of solar wind-like plasma to study
  electron and ion temperature anisotropy instabilities and their
  interplay with turbulence.

- Shearing box simulations to study accretion disk instabilities
  and turbulence, e.g., MRI.

- Global special and/or general relativity simulations of compact
  object accretion disks and magnetospheres.

- High beta fluid turbulence to study the role of Alfven wave
  disruptions due to temperature anisotropy instabilities.

- Self-consistent test particles for studying energetic particle
  production in shocks, reconnection, and global simulations.

- General turbulence studies to identify ion vs electron heating, and
  the heating mechanism/signature across a range of plasma parameters.

Some historical notes on hardware and key papers
------------------------------------------------

The first and perhaps greatest pioneer in computer hardware was
`Charles Babbage <https://en.wikipedia.org/wiki/Charles_Babbage>`_. He
essentially, ab-inito, designed a series of mechanical computers,
culminating in the Analytical Engine. Most of Babbage's machines were
not built in his lifetime. However, his design for the Analytical
Engine contains all the modern architectural details found in our
processors (of course, Babbage worked with mechanical machines and not
electronics). By a stroke of misfortune (probably as Babbage never
published anything), Babbage's ideas were not widely known, and
especially his designs fell into obscurity. They were only
rediscovered in 1960s, much after the modern von Neumann architecture
was designed. That two independent designs made a century apart should
be so similar is remarkable.

`Allan Bromley <https://en.wikipedia.org/wiki/Allan_G._Bromley>`_ is
the credited for rediscovering Babbage's legacy. See his `paper
<./_static/Bromley-1982.pdf>`_ in Annals of the History of Computing
for a detailed overview of the Analytical Engine. Babbage's Difference
engine has been built twice now. See `Computer History Museum page
<https://www.computerhistory.org/babbage/>`_. Babbage also designed an
extraordinary printer which was also built by the Science
Museum. London. See `BBC news report
<http://news.bbc.co.uk/2/hi/science/nature/710950.stm>`_.

The von Neumann architecture is named after the polymath `John von
Neumann <https://en.wikipedia.org/wiki/John_von_Neumann>`_. He worked
on his designs over years, including at the Institute of Advanced
Study where he designed a machined called the `IAS Machine
<https://en.wikipedia.org/wiki/IAS_machine>`_. von Neumann and Herman
Goldstine wrote the first major paper on `error analysis of Gaussian
elimination <https://epubs.siam.org/doi/10.1137/080734716>`_, bringing
numerical analysis into the mainstream of applied mathematics.

`Moore's Law <https://en.wikipedia.org/wiki/Moore's_law>`_ continues
to hold and number of transistors on-chip are doubling every two
years. However, we are hitting limit of clock speeds now and the way
towards faster computing is via multi-core machines. Many companies
ship chips with large number of cores. For example, Intel's `Cascade
Lake
<https://www.intel.com/content/www/us/en/design/products-and-solutions/processors-and-chipsets/cascade-lake/2nd-gen-intel-xeon-scalable-processors.html>`_
architecture has upto 28 cores. AMD's `Epyc chips
<https://www.amd.com/en/processors/epyc-7002-series>`_ come with up to
64 cores. These are now becoming available in various supercomputing
centers (including Princeton Research Computing).

References
----------

.. [RyuJones1995] Ryu, Dongsu and Jones, T.W. "Numerical
   Magnetohydrodynamics in Astrophysics: algorithms and tests for
   one-dimensional flow", *Astrophysical Journal*, **442** 228-258,
   1995. `PDF <./_static/1995ApJ___442__228R.pdf>`_

.. [LeVeque1992] R.J. LeVeque. "Numerical methods for conservation
   laws". Birkhäuser, 1992.	 

.. [Boozer2015] Boozer, A. H. (2015). "Theory of runaway electrons in
   ITER: Equations, important parameters, and implications for
   mitigation". Physics of Plasmas, **22** (3),
   032504–18. http://doi.org/10.1063/1.4913582   
