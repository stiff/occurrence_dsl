Occurrence DSL
=============

A quick sketch of an idea for a flexible recurring events DSL.

Requirements
-------

Code relies on [ActiveSupport](http://as.rubyonrails.org) date extensions from Rails.

Examples
-------

In ``irb``:

    require 'active_support/core_ext'
    require 'lib/occurrence'

    Occurrence.every.friday.each(Date.today, 10) {|d| p d }
    # Fri, 25 Feb 2011
    # Fri, 04 Mar 2011
    # Fri, 11 Mar 2011
    # Fri, 18 Mar 2011
    # Fri, 25 Mar 2011
    # Fri, 01 Apr 2011
    # Fri, 08 Apr 2011
    # Fri, 15 Apr 2011
    # Fri, 22 Apr 2011
    # Fri, 29 Apr 2011

    Occurrence.every.friday.last_in_month.each(Date.today, 10) {|d| p d }
    # Fri, 25 Feb 2011
    # Fri, 25 Mar 2011
    # Fri, 29 Apr 2011
    # Fri, 27 May 2011
    # Fri, 24 Jun 2011
    # Fri, 29 Jul 2011
    # Fri, 26 Aug 2011
    # Fri, 30 Sep 2011
    # Fri, 28 Oct 2011
    # Fri, 25 Nov 2011

    (Occurrence.every.friday.last_in_month | Occurrence.every.wednesday).each(Date.today, 15) {|d| p d }
    # Wed, 23 Feb 2011
    # Fri, 25 Feb 2011
    # Wed, 02 Mar 2011
    # Wed, 09 Mar 2011
    # Wed, 16 Mar 2011
    # Wed, 23 Mar 2011
    # Fri, 25 Mar 2011
    # Wed, 30 Mar 2011
    # Wed, 06 Apr 2011
    # Wed, 13 Apr 2011
    # Wed, 20 Apr 2011
    # Wed, 27 Apr 2011
    # Fri, 29 Apr 2011
    # Wed, 04 May 2011
    # Wed, 11 May 2011
