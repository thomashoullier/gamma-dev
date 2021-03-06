# Gamma deviates
`gamma-dev` implements a pseudorandom number generator for the
Gamma distribution [1].

The following distributions are either special cases or derived
easily from the gamma distribution:
* ✓ [Beta](https://en.wikipedia.org/wiki/Beta_distribution): Package `beta-dev`.
* [Exponential](https://en.wikipedia.org/wiki/Exponential_distribution):
  is a special case of gamma. However, please use
  [exp-dev](https://github.com/thomashoullier/exp-dev) as it is more efficient.
* ✖ Chi-square
* ✖ Erlang
* ✖ F-distribution

## Usage
### Gamma
For the gamma distribution, you need to instantiate a number
generator with the set of parameters you want to use. We use the
following parameters:
* `a` (alpha in [2]): shape parameter
* `b` (beta in [2]): scale parameter

#### Instantiation
**make-gamma-gen** a b => Instance of *gamma-gen*

```common-lisp
(setf generator (make-gamma-gen a b))
```

Create a pseudorandom number generator for the Gamma distribution with
shape parameter *a* and scale parameter *b*.

#### Drawing
**draw** gamma-gen => Pseudorandom number

```common-lisp
(draw generator)
```

Draw a pseudorandom number using the generator instance.

#### Reading parameters back
You can read back the parameters of the generator with:

```common-lisp
(a generator)
(b generator)
```

### Beta
In very much the same way:

```common-lisp
(setf generator (beta-dev:make-beta-gen alpha beta))
(beta-dev:draw generator) ;=> pseudorandom number
(beta-dev:alpha generator) ;=> alpha
(beta-dev:beta generator) ;=> beta
```

## Implementation
We use the algorithm by Tanizaki [2]. It involves a rejection of
uniform variates. We use the in-built `random`.

## Histograms
### Gamma
We generate histograms for the gamma distribution with some
shape and scale parameters (see [histograms](doc/histograms.lisp)).

![gamma-histograms](doc/gamma-pdfs.svg)

This looks good enough when compared with the analytical PDFs plotted
on Wikipedia [3].

![wiki-gamma-pdfs](doc/wikipedia-gamma-pdfs.svg)

### Beta
![beta-histograms](doc/beta/beta-pdfs.svg)
![wiki-beta-pdfs](doc/beta/wikipedia-beta-pdfs.svg)

## Caveats
* There are some specializations etc. to perform for performance if that is
  what you need.
* The algorithm by Tanizaki [2] is, according to its own author, not the best
  algorithm performance-wise for all choices of parameters. An efficient gamma
  pseudorandom generator would need to incorporate several of these algorithms
  and switch depending on the parameters.

## Test
Launch tests with:

```common-lisp
(asdf:test-system "gamma-dev")
```

Includes a quick performance test.

## Dependencies
* `gamma-dev`: None.
* `gamma-dev/test`:
  * [rove](https://github.com/fukamachi/rove)

## References
1. https://en.wikipedia.org/wiki/Gamma_distribution
2. H. Tanizaki, “A simple gamma random number generator for arbitrary shape
   parameters,” Economics Bulletin 3(7), 1–10 (2008).
3. https://en.wikipedia.org/wiki/File:Gamma_distribution_pdf.svg
